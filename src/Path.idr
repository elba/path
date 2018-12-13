module Path

import public Path.Parse

%access export

public export
data Absity = Abs | Rel

public export
data Fility = Dir | File

-- TODO: Maybe have it take a Fility too?
||| A valid part of a path. No slashes, no control characters.
data Part = RawPart String

Show Part where
    show (RawPart s) = s

part : String -> Maybe Part
part s = if s == neutral
    then Nothing
    else if any (\x => x == '/' || isControl x) $ unpack s
    then Nothing
    else Just $ RawPart s

-- GADT for constructing paths
-- See purescript-pathy, data-filepath
data Path : (a : Absity) -> (f : Fility) -> Type where
    Root  : Path Abs Dir
    Cur   : Path Rel Dir
    DirP  : Path a Dir -> Part -> Path a Dir
    FileP : Path a Dir -> Part -> Path a File

Show (Path a b) where
    show Root        = "/"
    show Cur         = "."
    show (DirP u (RawPart s))  = show u ++ s ++ "/"
    show (FileP u (RawPart s)) = show u ++ s

infixr 5 </>

(</>) : Path b Dir -> Path Rel t -> Path b t
(</>) p Cur = p
(</>) p (DirP r pt) = DirP (p </> r) pt
(</>) p (FileP r pt) = FileP (p </> r) pt

parent : Path b t -> Path b Dir
parent Root = Root
parent Cur = Cur
parent (DirP p _) = p
parent (FileP p _) = p

filename : Path b File -> String
filename (FileP _ (RawPart s)) = s

parseAbsDir : String -> Maybe (Path Abs Dir)
parseAbsFile : String -> Maybe (Path Abs File)
parseRelDir : String -> Maybe (Path Rel Dir)
parseRelFile : String -> Maybe (Path Rel File)
