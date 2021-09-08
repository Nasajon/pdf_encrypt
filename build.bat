@SET PYTHONPATH=%CD%\src
@SET PARAMS=-y --clean^
 --onefile^
 -p %PYTHONPATH%^
 --name "bloqueadorPdf"^
 --distpath "%NSBIN%"^
 --workpath "%NSDCU%"

@IF DEFINED JENKINS_HOME (
	@SET PARAMS=%PARAMS% --version-file "%WORKSPACE%\output\VersionInfo2"
)

@IF EXIST venv (
  @CALL @%CD%\venv\Scripts\deactivate.bat
)

@IF EXIST venv64 (
  @CALL @%CD%\venv64\Scripts\deactivate.bat
)

@ECHO ##### Criando o ambiente virtual#####

@python -m venv --clear venv

@ECHO ##### Compilando o projeto#####

@CMD "/c @%CD%\venv\Scripts\activate.bat && @pip install -r requirements.txt && @pyinstaller %PARAMS% Bloqueador.py && @%CD%\venv\Scripts\deactivate.bat"
