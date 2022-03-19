---
title: "wifi-presence"
date: 2022-03-19T10:31:11-06:00
draft: false
---

Presence detection for home automation: [awilliams/wifi-presence](https://github.com/awilliams/wifi-presence).

### How
It runs on a WiFi router and hooks in to the access point software to receive information about when WiFi clients connect and disconnect from the access point.
It then publishes those events to an MQTT broker, which can be consumed by home automation software such as [Home Assistant](https://www.home-assistant.io/integrations/mqtt_room/).

![wifi-presence](/images/wifi-presence.png "wifi-presence")
