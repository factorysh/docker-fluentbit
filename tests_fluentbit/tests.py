from fluent import sender


logger = sender.FluentSender("app", host="fluentd", port=24224)
print("Sender:", logger)

res = logger.emit("test", {"from": "userA", "to": "userB"})
print("Result:", res)
if not res:
    raise RuntimeError(logger.last_error)

logger.close()
