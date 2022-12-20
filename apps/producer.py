from kafka import KafkaProducer
from time import sleep

if __name__ == '__main__':
    producer = KafkaProducer(bootstrap_servers='localhost:9094')
    for _ in range(100):
        producer.send('foobar', b'some_message_bytes')
        sleep(10)
