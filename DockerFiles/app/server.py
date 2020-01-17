from http.server import BaseHTTPRequestHandler, HTTPServer
import time

hostName = "jenkinssshslave.westeurope.cloudapp.azure.com"
serverPort = 8081

class MyServer(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(bytes("<html><head><title>My python web application</title></head>", "utf-8"))
        self.wfile.write(bytes("<body><p>This is python web server application!</p></body></html>", "utf-8"))

if __name__ == "__main__":        
    webServer = HTTPServer((hostName, serverPort), MyServer)
    print("Server started http://%s:%s" % (hostName, serverPort))

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("Server stopped.")