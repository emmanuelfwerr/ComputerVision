## Welcome to my Computer Vision repository

Some nice things...

### Multiview Projection

The goal of this project was to implement forward (3D point to 2D point) and inverse (2D point to
3D ray) camera projection, and to perform triangulation from two cameras to do 3D reconstruction 
from pairs of matching 2D image points.

The specific tasks were to project 3D coordinates (sets of 3D joint locations on a human body,
measured by motion capture equipment) into image pixel coordinates that we could overlay on top 
of an image, to then convert those 2D points back into 3D viewing rays, and then triangulate
the viewing rays of two camera views to recover the original 3D coordinates we started with.

### Motion Detection

The goal of this project was to implement four simple motion detection algorithms, run them on 
short videos, and compare the results. The four algorithms are:
  Simple Background Subtraction
  Simple Frame Differencing
  Adaptive Background Subtraction
  Persistent Frame Differencing

We were required to implement all four in one program and generate, as output, a four-panel frame
showing the results of each algorithm, on each video frame, and generate a video of the results.

### How to use Markdown

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

## Editing

You can use the [editor on GitHub](https://github.com/emmanuelfwerr/Computer-Vision/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
