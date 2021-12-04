import os
from http.server import HTTPServer, BaseHTTPRequestHandler

host = ('0.0.0.0', 14514)

class Resquest(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()
        with open(os.path.expanduser("~/.ssh/id_rsa.pub"), "r") as f:
            self.wfile.write(('\n' + f.read() + '\n').encode('utf-8'))

if __name__ == '__main__':
    server = HTTPServer(host, Resquest)
    print("Starting server, listen at: %s:%s" % host)
    server.serve_forever()
