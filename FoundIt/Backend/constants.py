"""
File containing important constants used for the CornellFindIt App.

Authors: Michael Gaile, Cornell App Dev Team
Date: 12/1/2023
"""
import os
from dotenv import load_dotenv

load_dotenv()
EXTENSIONS = ["png", "gif", "jpg", "jpeg"]
BASE_DIR = os.getcwd()
S3_BUCKET_NAME = os.environ.get("S3_BUCKET_NAME")
S3_BASE_URL = f"https://{S3_BUCKET_NAME}.s3.us-east-1.amazonaws.com"
PASSWORD = os.environ.get("PASSWORD")
