from kafka import KafkaConsumer

if __name__ == '__main__':
    consumer = KafkaConsumer('foobar', bootstrap_servers='localhost:9094', auto_offset_reset='earliest',
                             auto_commit_interval_ms=1000)
    for msg in consumer:
        print(msg)