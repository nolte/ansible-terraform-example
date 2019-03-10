import os
import pytest

dir_path = os.path.dirname(os.path.realpath(__file__))

@pytest.mark.parametrize("state_path", [
    os.environ.get('PLAN_FILE_PATH')
    ])
def test_state_file_created_to_module(host,state_path):
    passwd = host.file(state_path)
    assert passwd.exists
