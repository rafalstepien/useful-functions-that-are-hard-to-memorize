import cProfile
import pstats


def get_profiling_stats(func, output_filename):
    with cProfile.Profile() as pr:
        func()
    stats = pstats.Stats(pr)
    stats.sort_stats(pstats.SortKey.TIME)
    stats.dump_stats(filename=f'{output_filename}')
