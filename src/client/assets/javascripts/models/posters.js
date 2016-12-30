type Poster = {
	url: string;
  name: string;
  width: number;
  height: number;
};

export type PostersMap = { [id: string]: Poster };

export type State = {
  selectedPosterId: string,
  posters: PostersMap
};
