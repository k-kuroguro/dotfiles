if command -v gcloud &> /dev/null; then
   gcloud() {
      command gcloud "$@"
      export PROMPT_GCLOUD_ENABLED=1
   }
fi
