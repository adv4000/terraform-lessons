# ------------------------------------------------------------------------------
# Simple Lambda Function which print payload
#  
# Version  Date               Name            Info
# 1.0      15-October-2025    Denis Astahov   Initial Version
#
# ------------------------------------------------------------------------------

def lambda_handler(event, context):
    print("Incoming Event:")
    print(event)

    message = {
         "message": "Lambda got this Payload:",
         "payload": event
    }

    return message
