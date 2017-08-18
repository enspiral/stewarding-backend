defmodule MatchMaker do
  alias Stewarding.Person

   def match(person) do
     case Person.get_previous(person) do
       nil -> nil
       steward -> %Relationship{:source => steward, :target => person}
     end
   end
end
