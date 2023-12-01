postgres:
	docker run --name my_postgres -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123 -d postgres:12-alpine

createdb:
	docker exec -it my_postgres createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it my_postgres dropdb --username=postgres simple_bank