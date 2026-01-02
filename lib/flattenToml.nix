lib: set:
let
  inherit (lib)
    foldl elemAt concatStringsSep getAttr attrNames concatMap removeAttrs last
    recursiveUpdate isAttrs sublist length;

  toPathValuePair = set:
    let
      attrList = attrNames set;
      createAttrs = name: set: accum:
        let
          mainName = "main";
          attrPath = if (last accum) == mainName then
            concatStringsSep "." (sublist 0 ((length accum) - 1) accum)
          else
            concatStringsSep "." accum;
          attrSet = { "${name}" = (getAttr name set); };
        in [ attrPath attrSet ];

      inner = name: set: accum:
        let val = getAttr name set;
        in if isAttrs val then
          let
            newSet = removeAttrs val [ name ];
            names = attrNames newSet;
            newAccum = accum ++ [ name ];
          in concatMap (x: inner x newSet newAccum) names
        else
          map (name: createAttrs name set accum) (attrNames set);
    in let cleaned = map (name: inner name set [ ]) attrList;
    in lib.flatten cleaned;

  intoDoubles = list: accum: index:
    if index == (length list) then
      accum
    else
      let
        newAccum = accum
          ++ [{ "${(elemAt list index)}" = (elemAt list (index + 1)); }];
      in intoDoubles list newAccum (index + 2);

in foldl (lhs: rhs: recursiveUpdate lhs rhs) { }
(intoDoubles (toPathValuePair set) [ ] 0)

