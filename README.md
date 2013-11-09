brush
=====

Cleanup tool for Logstash using an elasticsearch backend

Still in it's very early phases.
`brush hours` and `brush days` work. `brush days` **should** be safe for non-logstash data.

This tool assumes you use the default `logstash-%{+YYYY.MM.dd}` index. For now.
