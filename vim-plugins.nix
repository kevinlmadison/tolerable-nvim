{
  vimUtils,
  fetchFromGitHub,
  ...
}: [
  (vimUtils.buildVimPlugin {
    name = "coc-lit-html";
    src = fetchFromGitHub {
      owner = "fannheyward";
      repo = "coc-lit-html";
      rev = "0c942ee11b2f1309db8c7db2bbd65a07dc64fcf2";
      hash = "sha256-WGuNcD1uRUXbgJ6lm/DHcTnARF6GJ4qmycCDuWsOLpI=";
    };
  })
]
