__title__ = 'ArgumentParser (argparse)'
__author__ = 'Dennis C Meneses'
__description__ = 'my attempt to have argparse for Python 2.2'
__start_date__ = '2-Nov-2022'
__alpha_date__ = '5-Nov-2022'

import sys

class _ArgItem(object):
    def __init__(self, name, help, default, **kwargs):
        self.name = name
        self.help = help or ''
        self.default = default
        self.value = self.default

    def __str__(self):
        return "%(name)s\t\t%(help)s" % (
            {'name': self.name, 'help':self.help}
        )


class ParsedArg(object):
    pass


class ArgumentParser(object):
    """
    Handles the command-line parsing so your Python 2.2 applications
    can evaluate them as objects, supporting both positional 
    and keyword arguments.
    This does not attempt to recreate the argparse module in Python 3
    but simply provides enough functionality for most use cases.
    """
    def __init__(self, prog=None, description=None):
        self.prog = prog or sys.argv[0]
        self.description = description

        self.positionalargs = []
        self.keywordargs = {}
    

    def idfromkwarg(self, linekwarg):
        linekwarg = str(linekwarg).strip()
        keywordindex = linekwarg.rfind('-') + 1
        return linekwarg[keywordindex:]


    def add_argument(self, name, help='', default=''):
        if name.startswith('-'):
            # kw-args
            tname = self.idfromkwarg(name)
            self.keywordargs[tname] = (_ArgItem(tname, help, default))
        else:
            # p-args
            self.positionalargs.append(_ArgItem(name, help, default))


    def parse_args(self):
        if len(sys.argv) < 2 or sys.argv[1] in ('-h', '--help'):
            print self._generatehelp()
            return None

        # too bad the shlex.split exists in 2.3 (not 2.2)
        argchunks = sys.argv[1:]        # remove the scriptname from list

        parsed = ParsedArg()

        parg_index = -1
        for arg in argchunks:
            # split the args into positional and keyword
            if arg.startswith('-'):
                # keyword arg
                parts = arg.split('=', 1)
                tname = self.idfromkwarg(parts[0])
                tvalue = str(parts[1]).strip()
                # update the reference
                if tname in self.keywordargs:
                    # update only if that was defined
                    self.keywordargs[tname].value = tvalue

                    # crete property
                    setattr(parsed, tname, tvalue)
            else:
                # positional arg
                parg_index += 1
                if parg_index < len(self.positionalargs):
                    # update the reference
                    tvalue = str(arg).strip()
                    self.positionalargs[parg_index].value = tvalue
                    setattr(parsed, self.positionalargs[parg_index].name, tvalue)

        return parsed


    def _generatehelp(self):
        helplines = []

        helplines.append('usage: %(progname)s' % ({'progname': self.prog}))
        
        helplines.append('\npositional arguments:')
        for parg in self.positionalargs:
            helplines.append(str(parg))

        helplines.append('\nkeyword arguments:')
        for id, karg in self.keywordargs.items():
            helplines.append(str(karg))

        return '\n'.join(helplines)


