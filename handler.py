import datetime
import logging
import psycopg2

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

DB_CXN_STRING = "postgresql://taps3:StintEchoingShady@localhost:5432/eric_crm"
cxn = psycopg2.connect(DB_CXN_STRING)


def run(event, context):
    current_date = datetime.datetime.now().date()

    logger.info(f"Current Date: {current_date}")

    cur = cxn.cursor()
    query = f"SELECT * FROM event WHERE '{current_date}' = ANY (class_dates);"
    cur.execute(query)
    result = cur.fetchall()

    logger.info(result)

    return f"Function Complete ({context.function_name})"
