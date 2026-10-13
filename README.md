# Soft penetrable sphere model - amino-acid-level reference simulations

Code to reproduce the coarse-grained (amino-acid-level) Monte Carlo simulation
data in:

> P. Schurtenberger, M. Polimeni, S. Marzouk, R. Curtis, E. Zaccarelli,
> A. Stradner, *A soft penetrable sphere colloid model for the description of
> charge and excluded volume interactions in antibody solutions*.

Each antibody is represented at the amino-acid level (one bead per residue) and
simulated with **Faunus**. The notebooks generate the two-body potentials of
mean force (PMF) and the many-body centre-of-mass static structure factors S(q)
against which the paper's soft penetrable sphere colloid model is validated.

## Layout

```
pqr_inputs/        shared antibody structure files (.pqr)  -- see pqr_inputs/README.txt
Fig_2/             PMF, hard-sphere potential            (Figure 2)
Fig_5_6/           PMF, Yukawa + Lennard-Jones           (Figures 5, 6)
Fig_3_4_7/         many-body S(q), hard-sphere           (Figures 3, 4, 7)
Fig_10/            many-body S(q), Yukawa + Lennard-Jones (Figure 10)
environment.yml
```

Each figure folder holds one notebook that runs its simulations (writing one
sub-directory per run) and plots the corresponding figure(s).

## Prerequisites

You need a conda installation. If you don't have one, install **Miniforge**
(conda preconfigured with the conda-forge channel used here):
https://github.com/conda-forge/miniforge . Miniconda or Anaconda work too.

## Install

```bash
conda env create -f environment.yml
conda activate sps-mab
```

If conda cannot find `faunus=2.16.3` on conda-forge, install Faunus 2.16.3 by
your own method and make sure `faunus` and `yason.py` are on `PATH`.

## Launch Jupyter

The environment includes Jupyter. From the repo root:

```bash
jupyter lab        # or:  jupyter notebook
```

then open a figure folder's notebook.

## Running

1.  Open a notebook and run the cells top to bottom.

Simulations are launched locally by the `run_faunus()` function defined in each
notebook. It calls `yason.py input.yml | faunus -v 6`. **To run on a cluster or
otherwise change how jobs are launched, edit the body of `run_faunus()`** - the
rest of each notebook is unaffected.

The sample `micro`/`macro` values give short runs. For production-quality
statistics (as in the paper) increase `micro`; the many-body notebooks use
`micro = 10` as a quick default.

### Order matters

`Fig_5_6` overlays the hard-sphere PMF produced by `Fig_2`
(`../Fig_2/<name>/rdf.dat`). Run `Fig_2` first and keep that folder named
`Fig_2`.

## Notes on the potentials

* **Hard sphere** - excluded volume only.
* **Yukawa + Lennard-Jones** - screened Coulomb (Debye length set per ionic
  strength via `kappa()`) plus a short-range Lennard-Jones attraction with well
  depth 0.075 kT.
