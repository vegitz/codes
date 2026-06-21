""" Sample code to illustrate IOC (Inversion of Control)"""

__author__ = 'Dennis C. Meneses'
__site__ = 'https://coffeewithdennis.com/blog/'

from webframework import WebFramework
from webapp import ServicesApplication, ReportsApplication

def main(port=80):
    svc = ServicesApplication()
    rpt = ReportsApplication()

    wf = WebFramework()
    wf.register_url('services/wheel', svc)
    wf.register_url('services/engine', svc)
    wf.register_url('reports/diagnostics', rpt)
    wf.register_url('reports/pm_history', rpt)

    wf.run(port=port)


if __name__ == '__main__':
    main()

