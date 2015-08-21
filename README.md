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

## Use with Docker-Compose

Pincushion is particularly useful when developing an application with docker-compose.

Imagine you have the following setup:

    app1:
        image: myorg/app1
        expose:
            - 80

    app2:
        image: myorg/app2
        expose:
            - 80

You can then add pincushion in to expose your services to localhost.

    pin:
        image: stilvoid/pincushion
        ports:
            - 9000:80
        links:
            - app1
            - app2

And visit `app1.localhost:9000` in your browser :)

## Limitations

Pincushion assumes each linked container is serving HTTP and only has one port bound.
