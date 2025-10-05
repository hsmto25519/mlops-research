# mlops

<a target="_blank" href="https://cookiecutter-data-science.drivendata.org/">
    <img src="https://img.shields.io/badge/CCDS-Project%20template-328F97?logo=cookiecutter" />
</a>

For investigating the best MLOps structure

## Project Organization (ccds default)

```
├── LICENSE            <- Open-source license if one is chosen
├── Makefile           <- Makefile with convenience commands like `make data` or `make train`
├── README.md          <- The top-level README for developers using this project.
├── data
│   ├── external       <- Data from third party sources.
│   ├── interim        <- Intermediate data that has been transformed.
│   ├── processed      <- The final, canonical data sets for modeling.
│   └── raw            <- The original, immutable data dump.
│
├── docs               <- A default mkdocs project; see www.mkdocs.org for details
│
├── models             <- Trained and serialized models, model predictions, or model summaries
│
├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
│                         the creator's initials, and a short `-` delimited description, e.g.
│                         `1.0-jqp-initial-data-exploration`.
│
├── pyproject.toml     <- Project configuration file with package metadata for 
│                         machine_learning and configuration for tools like black
│
├── references         <- Data dictionaries, manuals, and all other explanatory materials.
│
├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
│   └── figures        <- Generated graphics and figures to be used in reporting
│
├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g.
│                         generated with `pip freeze > requirements.txt`
│
├── setup.cfg          <- Configuration file for flake8
│
└── machine_learning   <- Source code for use in this project.
    │
    ├── __init__.py             <- Makes machine_learning a Python module
    │
    ├── config.py               <- Store useful variables and configuration
    │
    ├── dataset.py              <- Scripts to download or generate data
    │
    ├── features.py             <- Code to create features for modeling
    │
    ├── modeling                
    │   ├── __init__.py 
    │   ├── predict.py          <- Code to run model inference with trained models          
    │   └── train.py            <- Code to train models
    │
    └── plots.py                <- Code to create visualizations
```

--------

## 全体像

以下全体像。あとで修正する。

```mermaid
graph TD
    subgraph "User"
        A["<i class='fa fa-user'></i> User's Browser"]
    end

    subgraph "Frontend on AWS"
        B["<i class='fa fa-cloud'></i> CloudFront CDN"]
        C["<i class='fa fa-archive'></i> S3 Bucket<br>(Static TypeScript App)"]
    end

    subgraph "Backend on AWS"
        D["<i class='fa fa-server'></i> API Gateway"]
        E["<i class='fa fa-microchip'></i> Lambda Function"]
        subgraph E ["Container"]
            F["<i class='fa fa-code'></i> FastAPI Backend"]
            G["<i class='fa fa-brain'></i> ML Model"]
        end
    end

    %% --- Define Interaction Flows ---
    A -- "1. Requests website" --> B;
    B -- "2. Fetches static files" --> C;
    C -- "3. Serves HTML, JS, CSS" --> A;
    
    A -- "4. User submits data for prediction<br>(API Call)" --> D;
    D -- "5. Triggers function" --> E;
    E -- "6. Invokes FastAPI endpoint" --> F;
    F -- "7. Loads model & gets prediction" --> G;
    G -- "8. Returns prediction" --> F;
    F -- "9. Sends HTTP response" --> E;
    E -- "10. Returns response" --> D;
    D -- "11. Forwards prediction to user" --> A;

    %% --- Styling ---
    linkStyle 0,1,2 stroke:#2a9d8f,stroke-width:2px
    linkStyle 3,4,5,6,7,8,9,10 stroke:#e76f51,stroke-width:2px

    classDef default fill:#f4f4f4,stroke:#333,stroke-width:2px
    classDef user fill:#e9c46a,stroke:#333,stroke-width:2px

    class A user
```

## Setup手順
### cookiecutter-data-scienceの構成を準備
* https://github.com/drivendataorg/cookiecutter-data-science
```
pipx install cookiecutter-data-science
ccds
```

## 実行
web app
```
source .venv/bin/activate  # you can use your own venv
uvicorn app.main:app --reload
```

## ライブラリ管理
requirements.txtはweb appのライブラリを管理
pyproject.tomlでML関連のライブラリを管理

### DVCでのdata管理

### traningに利用したサンプルのデータセット
* crocodile datasets
  * https://www.kaggle.com/datasets/zadafiyabhrami/global-crocodile-species-dataset/data