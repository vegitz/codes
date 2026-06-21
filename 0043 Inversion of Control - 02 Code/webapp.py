from webappinterface import WebApplication

class ReportsApplication(WebApplication):
    def on_get(self, request):
        return f"Generating Report for {request}"

class ServicesApplication(WebApplication):
    def on_get(self, request):
        return f"Running Services for {request}"
