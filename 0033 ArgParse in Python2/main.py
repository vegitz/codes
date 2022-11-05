import argparse

p = argparse.ArgumentParser(prog='Coffee App Demo')
p.add_argument('product', help='The coffee variant (ex. mocha)')
p.add_argument('--sugarlevel', help='Sugar percentage (0, 50, 75, 100) [default is 50]')
p.add_argument('--temp', help='Coffee temperature (hot or cold) [default is hot]')


order = p.parse_args()
if order:
    print "\nParams summary:"
    print order.__dict__

    # sample property access
    print "Preparing %(temp)s %(prod)s with %(slevel)d sugar level" % \
        (
            {'temp': order.temp, 'prod': order.product, 'slevel': int(order.sugarlevel)}
        )
