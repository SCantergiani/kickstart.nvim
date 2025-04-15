import math
from collections import defaultdict
from pathlib import Path

import pandas as pd
import requests
import typer
from aurys_scraper.config import DF_PATH, N_PAGES, SHORT_URL, TAG_MAP, TIMEOUT
from aurys_scraper.utils.funcs import (
    desc_df,
    fecha_articulo_df,
    text_cleaner,
    url_shortener,
)
from aurys_scraper.utils.user_agents import get_ua
from bs4 import BeautifulSoup
from loguru import logger
from tqdm import tqdm

app = typer.Typer()


@app.command()
def main(
    fuente: str = "Diario Financiero",
    tags_list: list[str] | None = None,
    n_pages: int = N_PAGES,
    output_path: Path = DF_PATH,
    short_url: bool = SHORT_URL,
    timeout: int = TIMEOUT,
) -> None:
    if tags_list is None:
        tags_list = [val for sublist in TAG_MAP.values() for val in sublist]

    tags_list = [tag.lower().strip() for tag in tags_list]

    # Diccionario auxiliar para almacenar los datos de las noticias
    df_noticias = defaultdict(list)

    # URL base para hacer scraping
    url_base = "https://www.df.cl/ultimasnoticias/p/{}"

    headers = {"user-agent": get_ua()}

    # Realizar el scraping hasta la página n_pages
    logger.info("Scraping Diario Financiero...")
    for i in tqdm(
        range(1, n_pages + 1), desc="scrapping páginas", unit="páginas", leave=False
    ):
        url = url_base.format(i)

        # Realizar la solicitud GET para obtener la página
        pagina = requests.get(url, headers=headers, timeout=timeout)
        soup = BeautifulSoup(pagina.content, "html.parser")

        # Encontrar la noticia destacada
        section = soup.find(class_="tax-list")
        noticias = section.find_all("article")

        for noticia in noticias:
            tag = (
                noticia.find(class_="card__tag").text
                if noticia.find(class_="card__tag")
                else None
            )
            tag = tag.split("|")[0].strip().lower() if tag else None
            if tag and tag in tags_list:
                title = noticia.find(class_="card__title").text.split("|")[-1]
                hrefs = [a.get("href") for a in noticia.find_all("a")]
                link = "https://www.df.cl" + hrefs[-1]
                link = url_shortener(link) if short_url else link
                img = "https://www.df.cl" + noticia.find("img").get("src")
                desc = desc_df(link)
                fecha = fecha_articulo_df(link, img)

                df_noticias["fuente"].append(fuente)
                df_noticias["tag"].append(tag)
                df_noticias["title"].append(title)
                df_noticias["desc"].append(desc)
                df_noticias["fecha"].append(fecha)
                df_noticias["link"].append(link)
                df_noticias["img"].append(img)

                # Limpieza de texto
                df_noticias = dict(df_noticias)
                df_noticias = {
                    k: [text_cleaner(text) for text in v]
                    for k, v in df_noticias.items()
                }

    logger.info("Creando DataFrame...")
    df_noticias = pd.DataFrame(df_noticias)
    logger.info("Guardando datos en archivo CSV...")
    df_noticias.to_csv(output_path, index=False, encoding="utf-8")

    test = {
        "one": {
            "two": {
                "tree": "hola",
                "four": "chao",
            },
        },
    }
