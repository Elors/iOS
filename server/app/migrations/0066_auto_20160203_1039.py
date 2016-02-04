# -*- coding: utf-8 -*-
# Generated by Django 1.9.2 on 2016-02-03 02:39
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0065_timeslot'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='status',
            field=models.CharField(choices=[('u', '待付款'), ('p', '已付款'), ('d', '已取消'), ('r', '退费')], default='u', max_length=2),
        ),
    ]
