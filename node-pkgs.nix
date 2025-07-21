{
  customNodeJS,
  mkYarnPackage,
  fetchFromGitHub,
  ...
}: [
  (mkYarnPackage rec {
    pname = "coc-tailwindcss3";
    version = "0.6.9";
    nodejs = customNodeJS;
    src = fetchFromGitHub {
      owner = "yaegassy";
      repo = pname;
      tag = "v${version}";
      hash = "sha256-ni2cU6Oc5cQc8RrFvCJPtmoMhHor2cybWSxwtp4DLso=";
    };
  })
]
