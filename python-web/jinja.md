# jinja

1. demo
    ```python3
    from jinja2 import Template
    tem_str = '''
        version: "3"
        services:
            {% for nic in nics %}
            replica_{{ nic.num }}:
                build: ./replica
                expose:
                    - "5000"
                    - "3128"
                networks:
                    - mobile_network_proxy
                environment:
                    - REPLICA_NAME=replica_{{ nic.num }}
                    - QL_DEV=/dev/ttyUSB{{ nic.tty_usb_num }}
                    - AT_DEV=/dev/ttyUSB{{ nic.tty_usb_num - 1 }}
                privileged: true
            {% endfor %}

            master:
                build: ./master
                ports:
                    - "3128:3128"
                    - "5000:5000"
                networks:
                    - mobile_network_proxy

            redis:
                image: redis
                expose:
                    - "6379"
                networks:
                    - mobile_network_proxy

        networks:
            mobile_network_proxy:
    nics = [{"num": num, "tty_usb_num": (num + 1) * 4 - 1} for num in range(5)]
    text = template.render(nics=nics)
    with open("docker-compose.yml", "w") as f:
        f.write(text)
    '''
    ```
2. more