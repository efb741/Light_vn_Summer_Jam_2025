#!/usr/bin/env python3

import http.server
import socketserver

PORT = 8000

import sys
import socketserver
from http.server import SimpleHTTPRequestHandler

class WasmHandler(SimpleHTTPRequestHandler):
    def end_headers(self):        
        # Include additional response headers to allow for use of the 
        # SharedArrayBuffer in Firefox.
        # https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer/Planned_changes
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")

        # Emulate csp in publishing sites
        # https://developers.google.com/web/fundamentals/security/csp?utm_source=devtools#eval_too
        # self.send_header("Content-Security-Policy", "script-src 'unsafe-eval' 'self'")

        SimpleHTTPRequestHandler.end_headers(self)

# Media type update needed for some browsers.
WasmHandler.extensions_map['.wasm'] = 'application/wasm'
WasmHandler.extensions_map['.js'] = 'application/javascript'

if __name__ == '__main__':
    with socketserver.TCPServer(("", PORT), WasmHandler) as httpd:
        print("Listening on port {}. Press Ctrl+C to stop.".format(PORT))
        httpd.serve_forever()

