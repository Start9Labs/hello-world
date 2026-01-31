use http_body_util::Full;
use hyper::body::Bytes;
use hyper::server::conn::http1;
use hyper::service::service_fn;
use hyper::{Request, Response};
use hyper_util::rt::TokioIo;
use std::convert::Infallible;
use std::net::SocketAddr;
use tokio::net::TcpListener;

async fn handle(_req: Request<hyper::body::Incoming>) -> Result<Response<Full<Bytes>>, Infallible> {
    Ok(Response::new(Full::new(Bytes::from_static(
        include_bytes!("index.html"),
    ))))
}

#[tokio::main]
async fn main() {
    let addr = SocketAddr::from(([0, 0, 0, 0], 80));
    let listener = TcpListener::bind(addr).await.unwrap();

    loop {
        let (stream, _) = listener.accept().await.unwrap();
        let io = TokioIo::new(stream);

        tokio::task::spawn(async move {
            if let Err(e) = http1::Builder::new()
                .serve_connection(io, service_fn(handle))
                .await
            {
                eprintln!("server error: {}", e);
            }
        });
    }
}
