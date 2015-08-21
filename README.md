# Pincushion

If you stick things in it, you know where they are when you need them.

Pincushion is a Docker container that simply runs nginx with virtual hosts configured for each other container linked to it.

## Example

Say you have two applications running in containers called `api` and `ui`.

Start pincushion, linking it to your running applications:

    docker run -d --link api:api --link ui:ui -p 9000:80 pincushion

Pincushion itself is then bound to port `9000` on your machine (as per the `-p 9000:80` parameter).

Then your applications will be available at: `http://api.localhost:9000/` and `http://ui.localhost:9000/`.

Simples.

## Limitations

Pincushion assumes each linked container is serving HTTP and only has one port bound.
