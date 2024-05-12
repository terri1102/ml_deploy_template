import logging
from typing import List

class Singleton(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super(Singleton, cls).__call__(*args, **kwargs)
        return cls._instances[cls]

class ApplicationLogger(metaclass=Singleton):
    def __init__(self):
        self.logger = self.get_logger()
    
    def get_logger(self, log_types: List = ["console"]):
        logger = logging.getLogger()
        formatter = logging.Formatter(
                "%(asctime)s - %(levelname)s - %(message)s"
            )

        if "console" in log_types:
            console_handler = logging.StreamHandler()
            console_handler.setFormatter(formatter)
            logger.addHandler(console_handler)
        return logger

    def info(self, msg: str, *args, **kwargs) -> None:
        self.logger.info(msg, *args, **kwargs)
