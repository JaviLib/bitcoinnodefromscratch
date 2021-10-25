# Configure a wordpress site to be accessible over tor

To add a wordpress site to your node you will need to add two services to our docker-compose file.

## oniondb
Uses the mariadb image and will store the data

- First you should add a section in your networks for an internal database network on an empty subnet.

`db:
    internal: true
    ipam:
      config:
        - subnet: 10.11.0.0/16`

- Next you should create the database service with -
    - a connection to the db network
    - a volume mounted to /var/lib/mysql inside the container,
    - port 3306 exposed
    - environment variables for the database name, user, password and root password

`oniondb:
    image: mariadb
    container_name: oniondb_build
    networks:
      - db
    volumes:
      - ./wordpress/oniondb:/var/lib/mysql
    restart: always
    expose:
      - "3306"
    environment:
      MYSQL_DATABASE: onionweb
      MYSQL_USER: onionweb
      MYSQL_PASSWORD: xxxxxx
      MYSQL_ROOT_PASSWORD: xxxxxx
`

## onionweb

Uses the wordpress image and will host the webserver.

- create the wordpress service that -
    - depends on both the tor and database containers
    - has port 80 exposed
    - has environment variables for the database set
    - had env variables for http_proxy set to the tor internal network to avoid wordpress leaking your real ip address
    - has a volume mounted to /var/www/html inside the container
    - has network connections to - 
        - the db network
        - the tor network with a static ip that you can pass into your torrc file

`onionweb:
    image: wordpress
    restart: always
    depends_on:
      - oniondb
      - tor
    expose:
      - 80
    environment:
      admin: admin:xxxxxx
      WORDPRESS_DB_NAME: onionweb
      WORDPRESS_DB_HOST: oniondb:3306
      WORDPRESS_DB_USER: onionweb
      WORDPRESS_DB_PASSWORD: xxxxxx
      http_proxy: http://tor:8118
      https_proxy: http://tor:8118
      HTTP_PROXY: http://tor:8118
      HTTPS_PROXY: http://tor:8118
    volumes:
      - ./wordpress/onionweb:/var/www/html
    networks:
      tor:
        ipv4_address: 10.6.0.105 
      db:`

- get your onion address -
    - run `dcu` to start your containers
    - run `sudo cat tor/lib/onionweb/hostname` to display your .onion address
