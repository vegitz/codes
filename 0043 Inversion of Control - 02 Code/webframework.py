class WebFramework:
    """ A dummy class to simulate a dummy web framework """
    path_handlers = {}

    def register_url(self, path, webapp):
        self.path_handlers[path] = webapp

    def on_get(self, url, request):
        try:
            handler = self.path_handlers[url]
            return handler.on_get(request)
        except Exception as e:
            return f"Invalid URL: {url}"

    def run(self, port=80):
        print(f"Server running on port {port}...")
        running = True
        while running:
            url = input(f'\nhttp://localhost:{port}/')
            path, _, params = url.partition('?')
            print(f"\nProcessing GET request:\n{path}\n{params}")

            if path == 'quit/':
                running = False
                break
            
            print(self.on_get(path, params))

