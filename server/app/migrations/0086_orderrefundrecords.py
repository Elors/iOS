# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-02-23 13:05
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('app', '0085_merge'),
    ]

    operations = [
        migrations.CreateModel(
            name='OrderRefundRecords',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('status', models.CharField(choices=[('u', '退费审核中'), ('a', '退费成功'), ('r', '退费被驳回')], default='u', max_length=2)),
                ('reason', models.CharField(blank=True, default='退费原因', max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('last_updated_at', models.DateTimeField(auto_now=True)),
                ('last_updated_by', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.Order')),
            ],
            options={
                'abstract': False,
            },
        ),
    ]