type Poster = {
	url: string;
  name: string;
  width: number;
  height: number;
};

type Title = {
};

export type PostersMap = { [id: string]: Poster };

export type State = {
  selectedPosterId: string,
  posters: PostersMap,
  titles: { [id: string]: Title };
};
