# Generated by Django 3.2.10 on 2022-05-08 07:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0002_articles_pwd'),
    ]

    operations = [
        migrations.AddField(
            model_name='articles',
            name='link',
            field=models.URLField(blank=True, null=True, verbose_name='文章链接'),
        ),
    ]
