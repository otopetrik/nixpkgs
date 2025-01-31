{ lib
, aiofiles
, buildPythonPackage
, cython
, fetchFromGitHub
, pytest-asyncio
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "aiocsv";
  version = "1.2.2";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "MKuranowski";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-lh+yHyHU+XrK4nk1xxrxgF5zGH7lP9jHdJ+m9ncfprw=";
  };

  nativeBuildInputs = [
    cython
  ];

  checkInputs = [
    aiofiles
    pytest-asyncio
    pytestCheckHook
  ];

  preBuild = ''
    export CYTHONIZE=1
  '';

  pythonImportsCheck = [
    "aiocsv"
  ];

  disabledTestPaths = [
    # Import issue
    "tests/test_parser.py"
  ];

  meta = with lib; {
    description = "Library for for asynchronous CSV reading/writing";
    homepage = "https://github.com/MKuranowski/aiocsv";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
