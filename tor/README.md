## Tor

Use tor to host your services via an onion address

# Add your service to the torrc file
`HiddenServiceDir /var/lib/tor/specter/` is the directory that will hold service spesific data

`HiddenServicePort 25441 10.6.0.77:25441` first gives the incoming port followed by the services container ip and port

# Get your .onion
navigate to your tor folder in your terminal and then execute the command `sudo cat /lib/{YOUR SERVICE NAME HERE}/hostname`
