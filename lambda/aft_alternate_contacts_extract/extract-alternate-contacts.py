import json
import logging
import os

logger = logging.getLogger()
if 'log_level' in os.environ:
    logger.setLevel(os.environ['log_level'])
    logger.info("Log level set to %s" % logger.getEffectiveLevel())
else:
    logger.setLevel(logging.INFO)

def extract_custom_fields(payload):
  try:
    raw_data = json.loads(payload['account_request']['custom_fields'])
    raw_alternate_contact = json.loads(raw_data['alternate_contact'])
    return raw_alternate_contact
  except Exception as e:
    logger.exception("Error on extract_custom_fields - {}".format(e))
    raise
  
def lambda_handler(event, context):
  try:
      logger.info("AFT Account Alternate Contact - Handler Start")
      logger.debug(json.dumps(event))
      payload = event["payload"]
      action = event["action"]
      ct_parameters = payload["account_request"]["control_tower_parameters"]
      logger.debug("{} - {}".format(action, payload))

      if action == "extract":
          extracted_data = extract_custom_fields(payload)
          output = {"control_tower_parameters": ct_parameters, "alternate_contact": extracted_data}
          return output
      elif action == "add":
          logger.info("Test")
      else:
          raise Exception(
              "Incorrect Command Passed to Lambda Function. Input: {action}. Expected: 'extract' or 'add'"
          )
      
  except Exception as e:
      logger.exception("Error on AFT Acount Alternate contact - {}".format(e))
      raise
