# Sending email alerts outside of st5

Use GPG mail-gate/postfix installed on 10.0.0.55 to automatically GPG encrypt mail.

The recipient **must** be `home_alerts@protonmail.com` as GPG mail-gate uses the recipient to pull out the right key. Any mail sent to another recipient will just be passed through

To send via mailgate in bash, set the header `smtp=10.0.0.55:25` ( STARTTLS being investigated )
E.G:

```bash
echo "hi" | mail -s "This is the subject" -r replyto@some.qualified.domain -S "smtp=10.0.0.55:25" to@another.domain
```

