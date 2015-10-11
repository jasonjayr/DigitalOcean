# DigitalOcean.pm

This branch is set to use the v2 api, since the v1 API is being depricated November 9th, 2015

API should be similar to the previous version


## Testing

You must copy tokenlist.template.pl to tokenlist.pl and set apropriate oath
tokens in there.  tokenlist.pl is on the gitignore list, and should never be
placed into a repository, since it's a bit painful to remove.

Note that the `read_only` token can be a OAuth token with read-only privs, no
actions that are known to require payment or that will change your environment
will be performed with those credentials.  The `read_write` token will provison
a droplet and attempt to connect to it, and this action **WILL INCUR A SMALL
CHARGE AGAINST YOUR ACCOUNT**.

