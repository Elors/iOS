# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-02-16 03:28
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0068_merge'),
    ]

    operations = [
        migrations.AddField(
            model_name='school',
            name='phone',
            field=models.CharField(default=None, max_length=20, null=True),
        ),
        migrations.AddField(
            model_name='school',
            name='service',
            field=models.CharField(default=None, max_length=200, null=True),
        ),
    ]