# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-02-16 08:59
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0070_auto_20160216_1453'),
    ]

    operations = [
        migrations.RenameField(
            model_name='school',
            old_name='member_service',
            new_name='member_services',
        ),
    ]