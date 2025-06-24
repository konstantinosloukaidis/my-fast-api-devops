from fastapi.testclient import TestClient

from fastapiproj import app

client = TestClient(app)


def test_read_main():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"msg": "Hello World"}

def test_read_item():
    response = client.get("/items/42?q=test")
    assert response.status_code == 200
    assert response.json() == {"item_id": 42, "q": "test"}

def test_echo():
    response = client.get("/echo/Hello%20FastAPI")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello FastAPI"}

def test_no_response():
    response = client.get("/nonexistent")
    assert response.status_code == 404