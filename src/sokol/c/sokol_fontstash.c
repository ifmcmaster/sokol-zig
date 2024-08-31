#include <stdio.h>  // needed by fontstash's IO functions even though they are not used
#include <stdlib.h>
#define FONTSTASH_IMPLEMENTATION
#include "fontstash/fontstash.h"
#include "sokol_gfx.h"
#include "sokol_gl.h"
#define SOKOL_FONTSTASH_IMPL
#define SOKOL_GLCORE
#include "sokol_fontstash.h"