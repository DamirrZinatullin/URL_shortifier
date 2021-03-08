#!/bin/sh

if [ "$DATABASE" = "postgres" ] 
then 
	echo "DB not yet run..."

	while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
		sleep 0.1
	done

	echo "DB did run"
fi
python manage.py migrate --no-input
python manage.py collectstatic --no-input
gunicorn url_shortifier.wsgi:application --bind 0.0.0.0:8000
exec "$@"