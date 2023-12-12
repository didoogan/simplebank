postgres:
	docker run --name my_postgres -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123 -d postgres:12-alpine

createdb:
	docker exec -it my_postgres createdb --username=postgres --owner=postgres simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:123@127.0.0.1:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:123@127.0.0.1:5432/simple_bank?sslmode=disable" -verbose down

dropdb:
	docker exec -it my_postgres dropdb --username=postgres simple_bank

sqlc:
	sqlc generate

test:
	go test -v -count=1  --cover ./...

server:
	go run main.go

mock:
	 mockgen -package mockdb -destination db/mock/store.go github.com/didoogan/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown test server mock