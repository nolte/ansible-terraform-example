import os
import pytest

@pytest.mark.parametrize("state_path", [
    os.environ.get('STATE_FILE_PATH'),
    os.environ.get('STATE_FILE_PATH')+".backup"
    ])
def test_state_file_created_to_module(host,state_path):
    passwd = host.file(state_path)
    assert passwd.exists
