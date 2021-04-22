---
title: "RPI3 Disable LEDs"
date: 2021-04-21T19:10:31-06:00
draft: false
---

To disable the LEDs on a Raspberry Pi 3, add the following to the `/boot/config.txt` file:

```text
dtparam=act_led_trigger=none
dtparam=act_led_activelow=off
dtparam=pwr_led_trigger=none
dtparam=pwr_led_activelow=off
```

More information: [Raspberry Pi Guide - 5.2 Control LEDs](https://mlagerberg.gitbooks.io/raspberry-pi/content/5.2-leds.html)
