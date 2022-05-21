# Generated by Django 3.2.10 on 2022-05-18 08:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0005_auto_20220517_2128'),
    ]

    operations = [
        migrations.AddField(
            model_name='moodcomment',
            name='addr',
            field=models.JSONField(null=True, verbose_name='用户地址信息'),
        ),
        migrations.AddField(
            model_name='moodcomment',
            name='ip',
            field=models.GenericIPAddressField(default='171.120.159.122', verbose_name='ip地址'),
        ),
    ]