export type Point = {
  x: number;
  y: number;
};

type TitleId = string;

type Title = {
};

export type State = {
	fonts: string[];
	initialTitle: TitleId;
	hoveredTitle: TitleId;
	dragged: {
		id: TitleId;
		position: Point;
		initialPosition: Point;
	};
	titles: { [id: string]: Title };
}